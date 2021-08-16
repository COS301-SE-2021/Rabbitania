using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text.Json;
using System.Threading.Tasks;
using System.Xml;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.Build.Construction;
using Newtonsoft.Json.Linq;

namespace backend_api.TFIDF
{
    public class TFIDF
    {

        private string _title;
        private string _body;
        private string _newTitle;
        private string _newBody;

        private const string Url = "http://127.0.0.1:5002/TFIDF/";
        private string _urlParameters = "";
        
        
        
        public TFIDF()
        {
            
        }

        public async Task<bool> tfidf_call(List<string> title, List<string> body, string newTitle, string newBody)
        {
            
            _title = "?threadTitle=" + string.Join(",", title);
            _body = "&threadBody=" + string.Join(",", body);
            _newTitle = "&newThreadTitle=" + newTitle;
            _newBody = "&newThreadBody=" + newBody;

            _urlParameters = _title + _body + _newTitle + _newBody;

            var pythonUrl = string.Format(Url + _urlParameters);
            var requestObjGet = WebRequest.Create(pythonUrl);
            requestObjGet.Method = "GET";
            HttpWebResponse responseObjGet = null;
            responseObjGet = (HttpWebResponse)await requestObjGet.GetResponseAsync();

            string pythonResult = null;
            await using (var stream = responseObjGet.GetResponseStream())
            {
                var sr = new StreamReader(stream);
                pythonResult = await sr.ReadToEndAsync();
                sr.Close();
            }

            Console.Write(pythonResult);
            Console.Write(pythonResult);
            return pythonResult == "true";
        }
    }
}