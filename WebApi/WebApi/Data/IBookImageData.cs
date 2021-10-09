using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;

namespace WebApi.Data
{
    public interface IBookImageData
    {
        List<BookImage> GetBookImages();

        BookImage GetBookImage(int id);

        BookImage addBookImage(BookImage category);

        void deleteBookImage(BookImage category);

        BookImage editBookImage(BookImage category);
        List<BookImage> GetImageByBook(int id);
    }
}
