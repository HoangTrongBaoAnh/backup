using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System;
using System.Linq;

namespace WebApi.Models.Seed
{
    public class admin_user
    {
        private ApplicationDbContext _configuration;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public admin_user(UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, ApplicationDbContext configuration)
        {
            _userManager = userManager;
            _configuration = configuration;
            _roleManager = roleManager;
        }

        public async void SeedAdminUser()
        {
            var user = new IdentityUser()
            {
                UserName = "Email@email.com",
                NormalizedUserName = "email@email.com",
                Email = "Email@email.com",
                NormalizedEmail = "email@email.com",
                EmailConfirmed = true,
                LockoutEnabled = false,
                SecurityStamp = Guid.NewGuid().ToString()
            };

            var roleStore = new RoleStore<IdentityRole>(_configuration);

            if (!_configuration.Roles.Any(r => r.Name == "admin"))
            {
                await roleStore.CreateAsync(new IdentityRole { Name = "admin", NormalizedName = "admin" });
            }

            if (!_configuration.Users.Any(u => u.UserName == user.UserName))
            {
                var password = new PasswordHasher<IdentityUser>();
                var hashed = password.HashPassword(user, "password");
                user.PasswordHash = hashed;
                var userStore = new UserStore<IdentityUser>(_configuration);
                await userStore.CreateAsync(user);
                await userStore.AddToRoleAsync(user, UserRoles.Admin);
                //await _userManager.AddToRoleAsync(user, UserRoles.Admin);
            }

            await _configuration.SaveChangesAsync();
        }

    }
}
