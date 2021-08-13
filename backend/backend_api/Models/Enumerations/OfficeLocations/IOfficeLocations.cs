namespace backend_api.Models.Enumerations.OfficeLocations
{
    public interface IOfficeLocations
    {
        OfficeLocation OfficeLocation { get; set; }
        
        string Name { get; set; }
    }
}