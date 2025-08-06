using ECommerceProject.Entities.Concrete;
using ECommerceProject.DataAccess.Abstract;

namespace ECommerceProject.DataAccess.Concrete
{
    public class EfCategoryDal : EfEntityRepositoryBase<Category, DataContext>, ICategoryDal
    {
    }
}
