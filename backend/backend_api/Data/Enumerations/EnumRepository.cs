using System.Threading.Tasks;
using backend_api.Models.Enumerations;

namespace backend_api.Data.Enumerations
{
    public class EnumRepository : IEnumRepository
    {
        public async Task<OfficeLocationModel> GetOfficeName()
        {
            return null;
        }
        
        public async Task<UserRolesModel> GetUserRoleType()
        {
            return null;
        }
    }
}