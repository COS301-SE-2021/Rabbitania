using System.Net;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class RetrieveNumThreadsResponse
    {
        private int _numThreads;
        private HttpStatusCode _code;

        public RetrieveNumThreadsResponse(int numThreads)
        {
            _numThreads = numThreads;
        }

        public RetrieveNumThreadsResponse(HttpStatusCode code)
        {
            _code = code;
        }
        
        public int NumThreads
        {
            get => _numThreads;
            set => _numThreads = value;
        }

        public HttpStatusCode Code
        {
            get => _code;
            set => _code = value;
        }

        
    }
}