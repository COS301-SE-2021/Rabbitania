namespace AgoraIO.Media
{
    
    public class AgoraSettings
    {
        private string _AppID;
        private string _certificate;

        public AgoraSettings(string appId, string _certificate)
        {
            _AppID = appId;
            _certificate = _certificate;
        }

        public AgoraSettings()
        {
        }

        public string AppId
        {
            get => _AppID;
            set => _AppID = value;
        }

        public string Certificate
        {
            get => _certificate;
            set => _certificate = value;
        }
    }
}