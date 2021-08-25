using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace backend_api.Services.Chat
{
    public class ChatService : IChatService
    {
        private static IConfiguration _config;
        
        public ChatService(IConfiguration config)
        {
            _config = config;
        }
        
        public string Encrypt()
        {
            var key = _config.GetValue<string>("Encrypt:Key");
            var text = _config.GetValue<string>("RabbitaniaV2:AppID");
            if (key.Length <= 1)
            {
                throw new Exception("Key not found, check env/secrets");
            }

            if (text.Length <= 1)
            {
                throw new Exception("AppID not found, check env/secrets");
            }

            byte[] i = new byte[16];
            byte[] arr;
            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key);
                aes.IV = i;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream memStream = new MemoryStream())
                {
                    using (CryptoStream crypto = new CryptoStream((Stream)memStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter writer = new StreamWriter((Stream)crypto))
                        {
                            writer.Write(text);
                        }

                        arr = memStream.ToArray();
                    }
                }
            }
            return Convert.ToBase64String(arr);
        }
    }
}