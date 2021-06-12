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

        public int GetUserId()
        {
            return UserID;
        }

        public void SetUserID(int UserID)
        {
            this.UserID = UserID;
        }

    }
}