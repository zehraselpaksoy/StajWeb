using Microsoft.AspNetCore.Http;
using System.Text;
using Newtonsoft.Json;

namespace ECommerceProject.Core.Helpers
{
    public static class SessionExtensions
    {
        public static void SetString(this ISession session, string key, string value)
        {
            if (value == null)
                session.Remove(key);
            else
                session.Set(key, Encoding.UTF8.GetBytes(value));
        }

        public static string GetString(this ISession session, string key)
        {
            if (session.TryGetValue(key, out var data))
                return Encoding.UTF8.GetString(data);
            return null;
        }

        public static void SetObjectAsJson(this ISession session, string key, object value)
        {
            var jsonString = JsonConvert.SerializeObject(value);
            session.SetString(key, jsonString);
        }

        public static T GetObjectFromJson<T>(this ISession session, string key)
        {
            var jsonString = session.GetString(key);
            return jsonString == null ? default : JsonConvert.DeserializeObject<T>(jsonString);
        }
    }
}
