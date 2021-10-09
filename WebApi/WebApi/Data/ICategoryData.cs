using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Models;

namespace WebApi.Data
{
    public interface ICategoryData
    {
        List<Category> GetCategories();

        Category GetCategory(int id);

        Category addCategory(Category category);

        void deleteCategory(Category category);

        Category editCategory(Category category);
    }
}
