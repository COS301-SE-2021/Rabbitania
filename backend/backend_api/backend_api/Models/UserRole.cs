namespace backend_api.Models
{
    public class UserRole
    {
        public int roleID { get; set; }
        public enum roles
        {
            CareTaker,
            Dev,
            Designer,
            ScrumMaster,
            Admin,
            Director,
            ClientAccountManager
        }
        public int level { get; set; }
    }
}