using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;

namespace WebApi.Data
{
    public class BookImageData : IBookImageData
    {
        private ApplicationDbContext _configuration;

        public BookImageData(ApplicationDbContext configuration)
        {
            _configuration = configuration;
        }
        public BookImage addBookImage(BookImage category)
        {
            _configuration.bookImages.Add(category);
            _configuration.SaveChanges();
            return category;
        }

        public void deleteBookImage(BookImage category)
        {
            _configuration.bookImages.Remove(category);
            _configuration.SaveChanges();
        }

        public BookImage editBookImage(BookImage category)
        {
            var cat = _configuration.bookImages.Find(category.Id);
            if (cat != null)
            {
                cat.Name = category.Name;
                cat.BookId = category.BookId;
                _configuration.bookImages.Update(cat);
                _configuration.SaveChanges();
            }
            return category;
        }

        public BookImage GetBookImage(int id)
        {
            return _configuration.bookImages.SingleOrDefault(x => x.Id == id);
        }

        public List<BookImage> GetBookImages()
        {
            return _configuration.bookImages.Include(b => b.Book).ToList();
        }

        public List<BookImage> GetImageByBook(int id)
        {
            return _configuration.bookImages.Where(x => x.BookId == id).ToList();
        }
    }
}
