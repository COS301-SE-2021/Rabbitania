using System.Collections;
using System.Collections.Generic;

namespace backend_api.Models.Forum.Responses
{
    public class RetrieveForumsResponse
    {
        private IEnumerable<Forums> _forums;

        public RetrieveForumsResponse(IEnumerable<Forums> forums)
        {
            this._forums = forums;
        }

        public IEnumerable<Forums> Forums
        {
            get => _forums;
            set => _forums = value;
        }
    }
}