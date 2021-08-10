using System.Collections;
using System.Collections.Generic;
using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class RetrieveThreadCommentsResponse
    {
        private IEnumerable<ThreadComments> _threadComments;
        private HttpStatusCode _code;

        

        public RetrieveThreadCommentsResponse(IEnumerable<ThreadComments> comments)
        {
            _threadComments = comments;
        }

        public RetrieveThreadCommentsResponse(HttpStatusCode code)
        {
            _code = code;
        }

        public IEnumerable<ThreadComments> ThreadComments
        {
            get => _threadComments;
            set => _threadComments = value;
        }
        
        public HttpStatusCode Code
        {
            get => _code;
            set => _code = value;
        }
    }
}