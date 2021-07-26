using System.Collections;
using System.Collections.Generic;
using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class RetrieveForumThreadsResponse
    {
        private IEnumerable<ForumThreads> _forumThreads;
        private HttpStatusCode _code;
        private InvalidForumRequestException _error;

        public RetrieveForumThreadsResponse(IEnumerable<ForumThreads> threads)
        {
            this._forumThreads = threads;
        }

        public RetrieveForumThreadsResponse(HttpStatusCode code, InvalidForumRequestException error)
        {
            _code = code;
            _error = error;
        }
        
        public IEnumerable<ForumThreads> ForumThreads
        {
            get => _forumThreads;
            set => _forumThreads = value;
        }
    }
}