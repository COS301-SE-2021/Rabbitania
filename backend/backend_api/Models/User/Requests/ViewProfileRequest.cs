using System;
using System.Buffers.Text;

namespace backend_api.Models.User.Requests
{
    public class ViewProfileRequest
    {
   
        private int UserID;
        
        public ViewProfileRequest(int UserID)
        {
            this.UserID = UserID;
        }

        public int UserId
        {
            get => UserID;
            set => UserID = value;
        }

    }
}