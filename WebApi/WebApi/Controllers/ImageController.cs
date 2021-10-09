using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Data;
using WebApi.Models;

namespace WebApi.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        private IWebHostEnvironment _webHostEnvironment;
        private IBookImageData _CategoryData;

        public ImageController(IBookImageData CategoryData, IWebHostEnvironment webHostEnvironment)
        {
            this._webHostEnvironment = webHostEnvironment;
            _CategoryData = CategoryData;
        }

        [HttpGet]
        public IActionResult GetCategories()
        {
            return Ok(_CategoryData.GetBookImages());
        }

        [HttpGet("{id}")]
        public IActionResult GetCategory(int id)
        {
            return Ok(_CategoryData.GetBookImage(id));
        }

        [HttpGet("{id}")]
        public IActionResult GetImageByProduct(int id)
        {
            return Ok(_CategoryData.GetImageByBook(id));
        }

        [HttpPost]
        public async Task<IActionResult> AddBookImage([FromForm] BookImage bookImage)
        {
            bookImage.Name = await SaveImage(bookImage.ImageFile);
            _CategoryData.addBookImage(bookImage);
            return Created(HttpContext.Request.Scheme + "://" + HttpContext.Request.Host + HttpContext.Request.Path + "/" + bookImage.Id, bookImage);
        }


        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateBookImage(int id, [FromForm] BookImage bookImage)
        {
            var name = await SaveImage(bookImage.ImageFile);
            var cat = _CategoryData.GetBookImage(id);
            if (cat != null)
            {
                bookImage.Name = name;
                bookImage.Id = cat.Id;
                _CategoryData.editBookImage(bookImage);
                return Ok(bookImage);
            }
            return NotFound();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteBookImage(int id)
        {
            var cat = _CategoryData.GetBookImage(id);
            if (cat != null)
            {
                _CategoryData.deleteBookImage(cat);
                return Ok();
            }
            return NotFound();
        }

        [NonAction]
        public async Task<string> SaveImage(IFormFile ImageFile)
        {
            String ImageName = new string(Path.GetFileNameWithoutExtension(ImageFile.FileName).Take(10).ToArray()).Replace(' ','-');
            ImageName = ImageName + DateTime.Now.ToString("yymmssff") + Path.GetExtension(ImageFile.FileName);
            var imagePath = Path.Combine(_webHostEnvironment.ContentRootPath, "Images", ImageName);
            using (var fileStream = new FileStream(imagePath, FileMode.Create))
            {
                await ImageFile.CopyToAsync(fileStream);
            }
            return ImageName;
        } 


    }
}
