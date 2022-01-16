using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Net.Http.Headers;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using WebApi.Configuration;
using WebApi.Models;
using WebApi.Models.DTOs.Requests;
using WebApi.Models.DTOs.Respone;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthManagementController : ControllerBase
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly JwtConfig _jwtConfig;

        public AuthManagementController(UserManager<IdentityUser> userManager, IOptionsMonitor<JwtConfig> optionsMonitor, RoleManager<IdentityRole> roleManager)
        {
            _roleManager = roleManager;
            _userManager = userManager;
            _jwtConfig = optionsMonitor.CurrentValue;
        }

        [HttpGet]
        public IActionResult getalluser()
        {
            var users = _userManager.Users.ToList();
            

            return Ok(users);
        }

        [HttpPost]
        public async Task<IActionResult> getuser()
        {
            var a = await HttpContext.GetTokenAsync("access_token");
            var token = Request.Headers[HeaderNames.Authorization].ToString().Replace("bearer ", string.Empty);
            //var stream = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImE3NGU3Nzk3LWM0YzItNDkyMi1iMzgxLTM0MmY3M2FkMzdmOSIsImVtYWlsIjoiYWJjZkBnbWFpbC5jb20iLCJzdWIiOiJhYmNmQGdtYWlsLmNvbSIsImp0aSI6IjMyYTU4ODkxLTc5YzItNGNjMy05NzkyLWU1YjI5ODJkYzVkZCIsIm5iZiI6MTYzMTY5ODE5MywiZXhwIjoxNjMxNzE5NzkzLCJpYXQiOjE2MzE2OTgxOTN9.O76-yNUYs2Xk0EGsEx8kXms7jsEs7Dp_qIyALyfeYNY";
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(token);
            var tokenS = jsonToken as JwtSecurityToken;
            var jti = tokenS.Claims.First(claim => claim.Type == "Id").Value;

            //var user = _userManager.Users.ToList();
            var xx = await _userManager.FindByIdAsync(jti);
            var role = _userManager.GetRolesAsync(xx);
            return Ok(xx);
        }

        [HttpGet]
        [Route("getallrole")]
        public IActionResult getrole()
        {
            var roles = _roleManager.Roles.ToList();
            return Ok(roles);
        }

        [HttpGet]
        [Route("getuserrole/{id}")]
        public async Task<IActionResult> getrole(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                var userRoles = await _userManager.GetRolesAsync(user);

                return Ok(userRoles);
            }
            return BadRequest();
        }


        [HttpPost]
        [Route("addrole/{id}")]
        public async Task<IActionResult> addRole(string id,[FromForm] ChangeRoleRequest changeRole)
        {
            var user = await _userManager.FindByIdAsync(id);
            if(user != null)
            {
                var role = await _roleManager.FindByNameAsync(changeRole.Role);

                if (role != null)
                {
                    await _userManager.AddToRoleAsync(user, changeRole.Role);

                    return Ok();
                }

                return BadRequest();
            }
            return BadRequest();
        }

        [HttpPost]
        [Route("removerole/{id}")]
        public async Task<IActionResult> removeRole(string id, [FromForm] ChangeRoleRequest changeRole)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                var role = await _roleManager.FindByNameAsync(changeRole.Role);

                if (role != null)
                {
                    await _userManager.RemoveFromRoleAsync(user, changeRole.Role);

                    return Ok();
                }

                return BadRequest();
            }
            return BadRequest();
        }

        [HttpPost]
        [Route("Register")]
        public async Task<IActionResult> Register([FromForm] UserRegistrationDto user)
        {
            if (ModelState.IsValid)
            {
                var existingUser = await _userManager.FindByEmailAsync(user.Email);
                if (existingUser != null) {
                    return BadRequest(new RegistrationRespone()
                    {
                        Erorrs = new List<string>()
                        {
                            "Email already in use"
                        },
                        Success = false
                    });
                }

                var newUser = new IdentityUser() { Email = user.Email, UserName = user.Username};
                var isCreated = await _userManager.CreateAsync(newUser, user.Password);
                if (isCreated.Succeeded)
                {
                    if (! await _roleManager.RoleExistsAsync(UserRoles.Admin))
                    {
                        await _roleManager.CreateAsync(new IdentityRole(UserRoles.Admin));
                    }
                    if (!await _roleManager.RoleExistsAsync(UserRoles.User))
                    {
                        await _roleManager.CreateAsync(new IdentityRole(UserRoles.User));
                    }
                    if (await _roleManager.RoleExistsAsync(UserRoles.Admin))
                    {
                        await _userManager.AddToRoleAsync(newUser, UserRoles.User);
                    }

                    var jwttoken = await generateJwtToken(newUser);
                    
                    return Ok(new RegistrationRespone()
                    {
                        Success = true,
                        Token = jwttoken
                    });
                }
                else
                {
                    return BadRequest(new RegistrationRespone()
                    {
                        Erorrs = isCreated.Errors.Select(x=>x.Description).ToList(),
                        Success = false
                    });
                }
            }

            return BadRequest(new RegistrationRespone() {
                Erorrs = new List<string>()
                {
                    "Invalid Payload"
                },
                Success = false
            });
        }

        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromForm] UserLoginRequest user)
        {
            if (ModelState.IsValid)
            {
                var existingUser = await _userManager.FindByEmailAsync(user.Email);
                if (existingUser == null)
                {
                    return BadRequest(new RegistrationRespone()
                    {
                        Erorrs = new List<string>()
                        {
                            "invalid login request"
                        },
                        Success = false
                    });
                }
                var isCorrect = await _userManager.CheckPasswordAsync(existingUser, user.Password );

                if (!isCorrect)
                {
                    return BadRequest(new RegistrationRespone()
                    {
                        Erorrs = new List<string>()
                        {
                            "invalid login request"
                        },
                        Success = false
                    });
                }
                else {
                    var jwttoken = generateJwtToken(existingUser);
                    return Ok(new RegistrationRespone()
                    {
                        Success = true,
                        Token = await jwttoken
                    });
                }
            }
            List<string> errors = new List<string>(ModelState.Values.SelectMany(x => x.Errors).Select(e => e.ErrorMessage));
            return BadRequest(new RegistrationRespone()
            {
                
                Erorrs = errors,
                Success = false
            });
        }

        private async Task<string> generateJwtToken(IdentityUser identityUser)
        {
            var userRoles = await _userManager.GetRolesAsync(identityUser);
            var authClaim = new ClaimsIdentity(new Claim[]
                {
                    new Claim("Id", identityUser.Id),
                    new Claim(JwtRegisteredClaimNames.Email, identityUser.Email),
                    new Claim(JwtRegisteredClaimNames.Sub, identityUser.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),

                });
            foreach(var userRole in userRoles)
            {
                authClaim.AddClaim(new Claim(ClaimTypes.Role, userRole));
            }
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_jwtConfig.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = authClaim,
                Expires = DateTime.UtcNow.AddHours(6),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),SecurityAlgorithms.HmacSha256Signature)
            };


            var token = jwtTokenHandler.CreateToken(tokenDescriptor);
            var jwtToken = jwtTokenHandler.WriteToken(token);
            
            return jwtToken;
        }
    }
}
