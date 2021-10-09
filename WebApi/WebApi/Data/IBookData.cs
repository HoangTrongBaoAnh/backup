using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;

namespace WebApi.Data
{
    public interface IBookData
    {
        List<Book> GetBooks();

        Book GetBook(int id);

        Book addBook(Book category);

        void deleteBook(Book category);

        Book editBook(Book category);
    }
}
