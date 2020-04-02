using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Web.ModelBinding;

namespace Entity
{
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false)]
    public class LocalizedRegexAttribute : RegularExpressionAttribute
    {
        static LocalizedRegexAttribute()
        {
            // necessary to enable client side validation
            DataAnnotationsModelValidatorProvider.RegisterAdapter(typeof(LocalizedRegexAttribute), typeof(RegularExpressionAttributeAdapter));
        }

        public LocalizedRegexAttribute(string _RegularExpression, string _ErrorMessageResourceName, Type _ErrorMessageResourceType)
            : base(LoadRegex(_RegularExpression))
        {
            ErrorMessageResourceType = _ErrorMessageResourceType;
            ErrorMessageResourceName = _ErrorMessageResourceName;

        }

        private static string LoadRegex(string key)
        {
            var resourceManager = new ResourceManager(typeof(Lokalizacija.Languages.langres));
            return resourceManager.GetString(key);
        }
    }
}
