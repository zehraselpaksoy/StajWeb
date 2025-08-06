using ECommerceProject.Business.Abstract;
using ECommerceProject.Entities.Concrete;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using ECommerceProject.DataAccess.Concrete; // DataContext için
using ECommerceProject.Core.Helpers; // SetObjectAsJson için

namespace ECommerceWeb1.Web.Controllers
{
    public class AccountController : Controller
    {
        private readonly DataContext _context; // DataContext'i enjekte etmelisin

        public AccountController(DataContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string email, string password)
        {
            var user = _context.Users.FirstOrDefault(u => u.Email == email && u.PasswordHash == password);

            if (user != null)
            {
                // Kullanıcı objesini JSON olarak session'a kaydet
                // Bu, _Layout.cshtml'de user objesinin dolu gelmesini sağlar
                HttpContext.Session.SetObjectAsJson("CurrentUser", user);

                // TempData["ReturnUrl"]'ı kullanmak istersen bu kısmı tekrar ekleyebilirsin
                // if (TempData["ReturnUrl"] != null)
                // {
                //     var returnUrl = TempData["ReturnUrl"].ToString();
                //     if (Url.IsLocalUrl(returnUrl))
                //     {
                //         return Redirect(returnUrl);
                //     }
                // }

                return RedirectToAction("Index", "Home");
            }

            ViewBag.ErrorMessage = "Geçersiz e-posta veya şifre."; // ViewBag.Error yerine ViewBag.ErrorMessage kullanıldı
            return View();
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(User user) // password parametresini kaldırdık, User objesiyle geliyor
        {
            if (ModelState.IsValid)
            {
                var existingUser = _context.Users.Any(u => u.Email == user.Email);
                if (existingUser)
                {
                    ModelState.AddModelError("Email", "Bu e-posta adresi zaten kayıtlı.");
                    return View(user);
                }

                user.PasswordHash = user.PasswordHash; // Şifreyi hash'lemeyi unutmayın! (Örn: BCrypt)
                user.CreatedAt = System.DateTime.Now;
                _context.Users.Add(user);
                _context.SaveChanges();

                // Yeni kayıt olan kullanıcıyı otomatik olarak giriş yapmış say
                HttpContext.Session.SetObjectAsJson("CurrentUser", user);
                return RedirectToAction("Index", "Home");
            }
            return View(user);
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Remove("CurrentUser"); // Session'dan kullanıcı objesini kaldır
            HttpContext.Session.Remove("Cart"); // Sepeti de temizleyebiliriz
            return RedirectToAction("Index", "Home");
        }
    }
}
