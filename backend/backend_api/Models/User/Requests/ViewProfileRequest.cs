using System;
using System.Buffers.Text;

namespace backend_api.Models.User.Requests
{
    public class ViewProfileRequest
    {
   
        private int _UserID;

        public ViewProfileRequest()
        {
            
        }
        
        public ViewProfileRequest(int UserID)
        {
            this._UserID = UserID;
        }

        public int UserId
        {
            get => _UserID;
            set => _UserID = value;
        }

    }
}