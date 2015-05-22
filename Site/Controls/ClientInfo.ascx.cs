using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Data;

public partial class Controls_ClientInfo : System.Web.UI.UserControl
{
    int mClientID = 0; 

    public int ClientID
    {
        set { mClientID = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        clientDateOfBirthCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;

        //if (!IsPostBack)
        //{
        //    DataTable countryList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.CountryList);
        //    Utils.FillSelector(rAddressClientCountryDDL, countryList, "Name", "Code");
        //    try
        //    {
        //        rAddressClientCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
        //        rAddressClientCountryDDL.Enabled = false;

        //        FillRealRaionDDDL();
        //    }
        //    catch
        //    { }           
        //}
    }

    protected void FillRealRaionDDDL()
    {
        if (rAddressClientCountryDDL.SelectedValue != null && !rAddressClientCountryDDL.SelectedValue.ToString().Equals(string.Empty))
        {
            int countruCOde = 0;
            int.TryParse(rAddressClientCountryDDL.SelectedValue.ToString(), out countruCOde);

            DataTable b_provinceList = Utils.ModuleMain().GetProvinceListByCountry(countruCOde);
            Utils.FillSelector(rAddressClientRaionDDL, b_provinceList, "Name", "Code");
        }
    }

    protected void ClearPersonalDataForms()
    {
        infoBoxTitleLabel.Text = string.Empty;

        //personalPhotoOnlyFileLink.Value = string.Empty;
        //clientNumeTextBox.Text = string.Empty;
        //clientPrenumeTextBox.Text = string.Empty;
        //clientDateOfBirthTextBox.Text = string.Empty;
        //clientPlaseOfBirthTextBox.Text = string.Empty;
        //addNewClientTelefonFixTextBox.Text = string.Empty;
        //addNewClientTelefonMobilTextBox.Text = string.Empty;
        //addNewClientTelefonMobil2TextBox.Text = string.Empty;
        //addNewClientEmailTextBox.Text = string.Empty;

        //////// personal address
        //rAddressClientLocalitateaTextBox.Text = string.Empty;
        //rAddressAddresaStradaTextBox.Text = string.Empty;

        //try
        //{
        //    rAddressClientCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
        //    FillRealRaionDDDL();
        //}
        //catch { }

        //rAddressClientRaionDDL.SelectedIndex = -1;
        //rAddressUrbanRuralDDL.SelectedIndex = 0;
    }

    public void Show()
    {
    //    string appPath = Utils.GetApplicationPath(Request);
    //    ClearPersonalDataForms();
        
    //    if (mClientID != 0)
    //    {
    //        Credits.DataObjects.Client clientObject = Utils.ModuleCredits().GetCleintObjectByID(mClientID);

    //        if (clientObject != null)
    //        {
    //            infoBoxTitleLabel.Text = "Informatia operativa pentru contragent";

    //            ////  general info                
    //            clientImage.ImageUrl = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ImageURL;
    //            clientNumeTextBox.Text = clientObject.FirstName;
    //            clientPrenumeTextBox.Text = clientObject.LastName;
    //            clientDateOfBirthTextBox.Text = clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat);
    //            clientPlaseOfBirthTextBox.Text = clientObject.PlaceOfBirth;
    //            addNewClientTelefonFixTextBox.Text = clientObject.TelefonFix;
    //            addNewClientTelefonMobilTextBox.Text = clientObject.TelefonMobil;
    //            addNewClientTelefonMobil2TextBox.Text = clientObject.TelefonMobil2;
    //            addNewClientEmailTextBox.Text = clientObject.Email;

    //            //////   address form
    //            rAddressClientLocalitateaTextBox.Text = clientObject.Raddress_Localitatea;
    //            rAddressAddresaStradaTextBox.Text = clientObject.Raddress_StradaAdresa;
              
    //            try { rAddressUrbanRuralDDL.SelectedValue = clientObject.Raddress_UrbanRural; }
    //            catch { }

    //            try { rAddressClientCountryDDL.SelectedValue = clientObject.Raddress_Country != 0 ? clientObject.Raddress_Country.ToString() : Constants.DefaultCountry.ToString(); }
    //            catch { }
    //            FillRealRaionDDDL();

    //            try { rAddressClientRaionDDL.SelectedValue = clientObject.Raddress_Raion.ToString(); }
    //            catch { }               
    //        }
    //    }
        
    //    this.programmaticModalPopup.Show();
    }
}