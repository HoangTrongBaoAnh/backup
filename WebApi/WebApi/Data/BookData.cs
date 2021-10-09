using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;

namespace WebApi.Data
{
    public class BookData : IBookData
    {
        private ApplicationDbContext _configuration;

        public BookData(ApplicationDbContext configuration)
        {
            _configuration = configuration;
        }
        public Book addBook(Book category)
        {
            _configuration.Books.Add(category);
            _configuration.SaveChanges();
            return category;
        }

        public void deleteBook(Book category)
        {
            _configuration.Books.Remove(category);
            _configuration.SaveChanges();
        }

        public Book editBook(Book category)
        {
            var cat = _configuration.Books.Find(category.Id);
            if (cat != null)
            {
                cat.Name = category.Name;
                cat.CategoryID = category.CategoryID;
                _configuration.Books.Update(cat);
                _configuration.SaveChanges();
            }
            return category;
        }

        public Book GetBook(int id)
        {
            return _configuration.Books.SingleOrDefault(x => x.Id == id);
        }

        public List<Book> GetBooks()
        {
            return _configuration.Books.Include(b => b.Category).ToList();
        }
    }
}
