using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;
using WebApi.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = UserRoles.Admin)]
    public class CategoryController : ControllerBase
    {
        private ICategoryData _CategoryData;

        public CategoryController(ICategoryData CategoryData)
        {
            _CategoryData = CategoryData;
        }

        /*
        private readonly IConfiguration _configuration;

        public CategoryController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        */
        [HttpGet]
        public IActionResult GetCategories()
        {
            return Ok(_CategoryData.GetCategories());
        }

        [HttpGet("{id}")]
        public IActionResult GetCategory(int id)
        {
            return Ok(_CategoryData.GetCategory(id));
        }

        [HttpPost]
        public IActionResult AddCategory(Category category)
        {
            _CategoryData.addCategory(category);
            return Created(HttpContext.Request.Scheme + "://" + HttpContext.Request.Host + HttpContext.Request.Path + "/" + category.Id,category);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateCategory(int id,Category category)
        {
            var cat = _CategoryData.GetCategory(id);
            if (cat != null)
            {
                category.Id = cat.Id;
                _CategoryData.editCategory(category);
                return Ok(category);
            }
            return NotFound();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCategory(int id)
        {
            var cat = _CategoryData.GetCategory(id);
            if(cat != null)
            {
                _CategoryData.deleteCategory(cat);
                return Ok();
            }
            return NotFound();
        }

        /*
        [HttpGet]
        public JsonResult Get()
        {
            string query = @"select * from dbo.categories";
            DataTable dt = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("DefaultConnection");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    dt.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(dt);
        }
        
        [HttpPost]
        public JsonResult Post(Category cat)
        {
            string query = @"insert into dbo.categories values(@name)";
            DataTable dt = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("DefaultConnection");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@name", cat.Name);
                    myReader = myCommand.ExecuteReader();
                    dt.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(dt);
        }

        [HttpPut]
        public JsonResult Put(Category cat)
        {
            string query = @"update dbo.categories set Name=@name where Id=@id";
            DataTable dt = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("DefaultConnection");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@name", cat.Name);
                    myCommand.Parameters.AddWithValue("@id", cat.Id);
                    myReader = myCommand.ExecuteReader();
                    dt.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(dt);
        }

        [HttpDelete("{id}")]
        public JsonResult Delete(int id)
        {
            string query = @"delete from dbo.categories where Id=@id";
            DataTable dt = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("DefaultConnection");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            { 
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@id", id);
                    myReader = myCommand.ExecuteReader();
                    dt.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(dt);
        }
        */
    }
}
