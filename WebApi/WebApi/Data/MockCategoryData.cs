using Microsoft.AspNetCore.Mvc;
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

        public List<Category> GetCategories(PaginationParam @params)
        {
            var categories = _configuration.Categories
                .ToList();
            var paginationmetada = new PaginationMetaData(categories.Count(),@params.Page,@params.ItemsPerPage);
            

            var category = categories.Skip((@params.Page - 1) * @params.ItemsPerPage)
                .Take(@params.ItemsPerPage).ToList();

            
            return category;
        }

        public Category GetCategory(int id)
        {
            return _configuration.Categories.SingleOrDefault(x => x.Id == id);
        }
    }
}
