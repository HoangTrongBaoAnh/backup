using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Data;
using WebApi.Models;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookController : ControllerBase
    {
        private IBookData _CategoryData;

        public BookController(IBookData CategoryData)
        {
            _CategoryData = CategoryData;
        }

        [HttpGet]
        public IActionResult GetCategories()
        {
            return Ok(_CategoryData.GetBooks());
        }

        [HttpPost]
        public IActionResult AddCategory([FromForm]Book book)
        {
            _CategoryData.addBook(book);
            return Created(HttpContext.Request.Scheme + "://" + HttpContext.Request.Host + HttpContext.Request.Path + "/" + book.Id, book);
        }

        [HttpGet("{id}")]
        public IActionResult GetCategory(int id)
        {
            return Ok(_CategoryData.GetBook(id));
        }


        [HttpPut("{id}")]
        public IActionResult UpdateCategory(int id,[FromForm] Book book)
        {
            var cat = _CategoryData.GetBook(id);
            if (cat != null)
            {
                book.Id = cat.Id;
                _CategoryData.editBook(book);
                return Ok(book);
            }
            return NotFound();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCategory(int id)
        {
            var cat = _CategoryData.GetBook(id);
            if (cat != null)
            {
                _CategoryData.deleteBook(cat);
                return Ok();
            }
            return NotFound();
        }
    }
}
