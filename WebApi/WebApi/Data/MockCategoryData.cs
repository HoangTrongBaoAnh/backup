using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApi.Data;
using WebApi.Models;

namespace WebApi.Data
{
    public class MockCategoryData : ICategoryData
    {
        private ApplicationDbContext _configuration;

        public MockCategoryData(ApplicationDbContext configuration)
        {
            _configuration = configuration;
        }
        public Category addCategory(Category category)
        {
            _configuration.Categories.Add(category);
            _configuration.SaveChanges();
            return category;
        }

        public void deleteCategory(Category category)
        {
            _configuration.Categories.Remove(category);
            _configuration.SaveChanges();
        }

        public Category editCategory(Category category)
        {
            var cat = _configuration.Categories.Find(category.Id);
            if (cat != null)
            {
                cat.Name = category.Name;
                _configuration.Categories.Update(cat);
                _configuration.SaveChanges();
            }
            return category;
        }

        public List<Category> GetCategories()
        {
            return _configuration.Categories.ToList();
        }

        public Category GetCategory(int id)
        {
            return _configuration.Categories.SingleOrDefault(x => x.Id == id);
        }
    }
}
