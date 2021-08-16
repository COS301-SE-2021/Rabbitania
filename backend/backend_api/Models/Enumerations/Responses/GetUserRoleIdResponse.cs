namespace backend_api.Models.Enumerations.Responses
{
    public class GetUserRoleIdResponse
    {
        private UserRoles _userRole;

        public GetUserRoleIdResponse(UserRoles userRole)
        {
            _userRole = userRole;
        }

        public GetUserRoleIdResponse()
        {
            
        }

        public UserRoles UserRole
        {
            get => _userRole;
            set => _userRole = value;
        }
    }
}