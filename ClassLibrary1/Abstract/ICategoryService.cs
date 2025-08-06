using ECommerceProject.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ECommerceProject.Business.Abstract
{
    public interface ICategoryService
    {
        Task<string?> GetAllCategoriesAsync();
        List<Category> GetAllWithHierarchy();
    }
}
