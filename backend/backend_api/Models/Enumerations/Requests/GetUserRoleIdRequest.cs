namespace backend_api.Models.Enumerations.Requests
{
    public class GetUserRoleIdRequest
    {
        private string _roleName;

        public GetUserRoleIdRequest(string roleName)
        {
            _roleName = roleName;
        }

        public GetUserRoleIdRequest()
        {
            
        }

        public string RoleName
        {
            get => _roleName;
            set => _roleName = value;
        }
    }
}