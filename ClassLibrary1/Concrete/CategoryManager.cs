using ECommerceProject.Business.Abstract;
using ECommerceProject.DataAccess.Concrete;
using ECommerceProject.Entities.Concrete;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;

namespace ECommerceProject.Business.Concrete
{
    public class CategoryManager : ICategoryService
    {
        private readonly DataContext _context;

        public CategoryManager(DataContext context)
        {
            _context = context;
        }

        public async Task<string?> GetAllCategoriesAsync()
        {
            var categories = await _context.Categories.ToListAsync();
            return JsonSerializer.Serialize(categories);
        }


        public List<Category> GetAllWithHierarchy()
        {
            return _context.Categories
                .Include(c => c.ParentCategory)
                .Include(c => c.SubCategories)
                .ToList();
        }
    }

}
