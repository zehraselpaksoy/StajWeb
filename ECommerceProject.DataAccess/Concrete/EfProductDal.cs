using ECommerceProject.Entities.Concrete;
using ECommerceProject.DataAccess.Abstract;

namespace ECommerceProject.DataAccess.Concrete
{
    public class EfProductDal : EfEntityRepositoryBase<Product, DataContext>, IProductDal
    {
    }
}
