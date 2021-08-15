namespace AgoraIO.Media
{
    public class AgoraSettings
    {
        private string AppID;
        private string certificate;

        public AgoraSettings(string appId, string _certificate)
        {
            AppID = appId;
            certificate = _certificate;
        }

        public AgoraSettings()
        {
        }

        public string AppId
        {
            get => AppID;
            set => AppID = value;
        }

        public string Certificate
        {
            get => certificate;
            set => certificate = value;
        }
    }
}