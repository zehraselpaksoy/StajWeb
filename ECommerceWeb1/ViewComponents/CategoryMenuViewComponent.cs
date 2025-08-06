using ECommerceProject.Business.Abstract;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using ECommerceProject.Entities.Concrete;

public class CategoryMenuViewComponent : ViewComponent
{
    private readonly ICategoryService _categoryService;

    public CategoryMenuViewComponent(ICategoryService categoryService)
    {
        _categoryService = categoryService;
    }

    public IViewComponentResult Invoke()
    {
        var categories = _categoryService.GetAllWithHierarchy();

        // ViewBag ile tüm kategorileri alt menüler için gönderiyoruz.
        ViewBag.AllCategories = categories;

        var topLevelCategories = categories.Where(c => c.ParentId == null).ToList();

        // View'in tam yolunu belirtiyoruz, böylece Shared klasöründe bulabilir.
        return View("~/Views/Shared/_CategoryMenu.cshtml", topLevelCategories);
    }
}