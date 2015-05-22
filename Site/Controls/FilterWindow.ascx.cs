using System;
using System.Data;
using System.Collections.Generic;
using System.Collections;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.Services;
using System.Text;
using System.Linq;

public partial class FilterWindow : System.Web.UI.UserControl
{    
    Unit mWidth = 350;
    Unit mHeight = 150;
    Unit mSelectButtonWidth = 100;
    string mTitleWindow = "Selection Dialog Box";
    string mSelectButtonText = "Please Select";
    bool mAllowMultiSelection = true;
    
    public Unit Width
    {
        get { return mWidth; }
        set { mWidth = value;  }
    }

    public Unit Height
    {
        get { return mHeight; }
        set { mHeight = value; }
    }

    public string AllowMultiSelJSLink
    {
        get { return  "AllowOnlyOneSelectOnGridView('" + filterGridView.ClientID + "', this);"; }
    }

    public Unit SelectButtonWidth
    {
        get { return mSelectButtonWidth; }
        set { mSelectButtonWidth = value; }
    }

    public string TitleWindow
    {
        get { return mTitleWindow; }
        set { mTitleWindow = value; }
    }

    public string SelectButtonText
    {
        get { return mSelectButtonText; }
        set { mSelectButtonText = value; }
    }

    public string DisplayValueField
    {
        get {return Session["DisplayValueField" + filterWindowBodyDiv.ClientID] != null ? (string)Session["DisplayValueField" + filterWindowBodyDiv.ClientID] : string.Empty; }
        set { Session["DisplayValueField" + filterWindowBodyDiv.ClientID] = value; }
    }

    public string DataValueFiled
    {
        get{ return Session["DataValueFiled" + filterWindowBodyDiv.ClientID] != null ? (string)Session["DataValueFiled" + filterWindowBodyDiv.ClientID] : string.Empty; }
        set { Session["DataValueFiled" + filterWindowBodyDiv.ClientID] = value; }
    }

    public DataTable DataSource
    {
        get { return Session[filterWindowBodyDiv.ClientID] != null ? (DataTable)Session[filterWindowBodyDiv.ClientID] : new DataTable(); }
        set { Session[filterWindowBodyDiv.ClientID] = value; }
    }

    public bool AllowMultiSelection
    {
        get { return mAllowMultiSelection; }
        set { mAllowMultiSelection = value; }
    }

    public List<int> SelectedValuesAsInt
    {
        get
        {
            List<int> resultList = new List<int>();

            if (!filterControlSelectedValuesHiddenF.Value.Equals(string.Empty))
            {
                string[] selValues = filterControlSelectedValuesHiddenF.Value.Split(';');
                if (selValues != null)
                {
                    for (int i = 0; i < selValues.Length; i++)
                    {
                        string val = selValues[i];
                        if (!string.IsNullOrEmpty(val))
                        {
                            int intVal = 0;
                            int.TryParse(val, out intVal);
                            if (intVal != 0)
                                resultList.Add(intVal);
                        }
                    }
                }
            }

            return resultList;
        }
    }

    public List<string> SelectedNames
    {
        get 
        {
            List<string> resultList = new List<string>();
            if (!filterControlSelectedNamesValuesHiddenF.Value.Equals(string.Empty))
            {
                string[] selValues = filterControlSelectedNamesValuesHiddenF.Value.Split(';');
                if (selValues != null)
                {
                    for (int i = 0; i < selValues.Length; i++)
                    {
                        string val = selValues[i];
                        if (!string.IsNullOrEmpty(val))
                        {
                            resultList.Add(val);
                        }
                    }
                }
            }
            return resultList;
        }
    }

    public List<string> SelectedValues
    {
        get
        {
            List<string> resultList = new List<string>();

            if (!filterControlSelectedValuesHiddenF.Value.Equals(string.Empty))
            {
                string[] selValues = filterControlSelectedValuesHiddenF.Value.Split(';');
                if (selValues != null)
                {
                    for (int i = 0; i < selValues.Length; i++)
                    {
                        string val = selValues[i];
                        if (!string.IsNullOrEmpty(val))
                        {
                            resultList.Add(val);
                        }
                    }
                }
            }

            return resultList;
        }

        set
        {
            List<string> inputList = null;
            filterControlSelectedValuesHiddenF.Value = string.Empty;
            filterControlSelectedNamesValuesHiddenF.Value = string.Empty;

            if (value != null)
            {
                inputList = value.ToArray().Select(p => p.Trim()).ToList();
                List<int> wasChecked = new List<int>();

                for (int i = 0; i < inputList.Count; i++)
                {
                    for (int j = 0; j < filterGridView.Rows.Count; j++)
                    {
                        CheckBox CheckBox = (CheckBox)filterGridView.Rows[j].FindControl("checkBoxID");
                        string displayField = filterGridView.Rows[j].Cells[1].Text;
                        string codeField = filterGridView.Rows[j].Cells[2].Text;

                        if (inputList[i].Equals(codeField))
                        {
                            CheckBox.Checked = true;
                            wasChecked.Add(j);
                            j = filterGridView.Rows.Count;

                            if (!mAllowMultiSelection || filterControlSelectedValuesHiddenF.Value.Equals(string.Empty))
                            {
                                filterControlSelectedValuesHiddenF.Value = codeField;
                                filterControlSelectedNamesValuesHiddenF.Value = displayField;
                            }
                            else
                            {
                                filterControlSelectedValuesHiddenF.Value += ";" + codeField;
                                filterControlSelectedNamesValuesHiddenF.Value += ";" + displayField;
                            }
                        }
                        else
                        {
                            if (!wasChecked.Contains(j) || !mAllowMultiSelection)
                                CheckBox.Checked = false;
                        }
                    }                   
                }                     
            }
        }
    }
    
    public void SetSelectionForAllItems(bool selected)
    {
        if (mAllowMultiSelection)
        {
            filterControlSelectedValuesHiddenF.Value = string.Empty;
            filterControlSelectedNamesValuesHiddenF.Value = string.Empty;

            foreach (GridViewRow item in filterGridView.Rows)
            {
                CheckBox CheckBox2 = (CheckBox)item.FindControl("checkBoxID");
                CheckBox2.Checked = selected;

                if (CheckBox2.Checked)
                {
                    string displayField = item.Cells[1].Text;
                    string codeField = item.Cells[2].Text;

                    if (filterControlSelectedValuesHiddenF.Value.Equals(string.Empty))
                    {
                        filterControlSelectedValuesHiddenF.Value += codeField;
                        filterControlSelectedNamesValuesHiddenF.Value += displayField;
                    }
                    else
                    {
                        filterControlSelectedValuesHiddenF.Value += ";" + codeField;
                        filterControlSelectedNamesValuesHiddenF.Value += ";" + displayField;
                    }
                }
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        filterWindowBodyDiv.Style.Value = "height:" + (int)(mHeight.Value - 50) + "px; ";
        divFilterPopup.Style.Value = "width: " + (int)mWidth.Value + "px; ";
        txtSearch.Width = (int)(mWidth.Value - 110);
        
        btnShowModalDiv.Style.Value = "width: " + (int)mSelectButtonWidth.Value + "px;";
        btnShowModalDiv.Attributes.Add("onclick", "$('#" + divFilterPopup.ClientID + "').showModal(); document.getElementById('" + txtSearch.ClientID + "').focus(); return false;  ");
        btnShowModalDiv.Value = mSelectButtonText;   
 
        WindowTitleLabel.Text = mTitleWindow;       

        selectAllCheckBox.Attributes["onclick"] = "CheckAllForGrid('" + filterGridView.ClientID + "', this);";
        txtSearch.Attributes["onkeyup"] = "Search('" + txtSearch.ClientID + "', '" + filterGridView.ClientID + "')";
        closeButton.Attributes["onClick"] = "$('#" + divFilterPopup.ClientID + "').hideModal();  ReturnToOldSelections" + this.ClientID + "(); return false;";
        
        selectAllCheckBox.Visible = mAllowMultiSelection;

        RegisterAllClientJavaScripts();
    }

    private void RegisterAllClientJavaScripts()
    {
        if (!Page.ClientScript.IsClientScriptBlockRegistered(typeof(Page), "ReturnToOldSelections" + this.ClientID))
        {
            StringBuilder cstext2 = new StringBuilder();
            cstext2.Append("<script type=text/javascript> function ReturnToOldSelections" + this.ClientID + "() { \r\n ");
            cstext2.Append("    var grid = document.getElementById('" + filterGridView.ClientID + "');  \r\n ");
            cstext2.Append("    var hiddentFValue = document.getElementById('" + filterControlSelectedValuesHiddenF.ClientID + "').value;  \r\n ");
            cstext2.Append("    var rows = grid.getElementsByTagName(\"tr\");  \r\n ");

            cstext2.Append("    for (i = 1; i < rows.length; i++) {  \r\n ");
            cstext2.Append("        var itemCode = rows[i].cells[2].innerHTML; \r\n ");
            cstext2.Append("        var countainValue = value_contains(hiddentFValue, itemCode);  \r\n ");
            cstext2.Append("        rows[i].cells[0].getElementsByTagName(\"input\")[0].checked = countainValue; \r\n ");
            cstext2.Append("    }   \r\n ");
            if (mAllowMultiSelection)  cstext2.Append("    document.getElementById('" + selectAllCheckBox.ClientID + "').checked = false   \r\n ");
            cstext2.Append("}  \r\n ");
            cstext2.Append("</script>  \r\n ");

            Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "ReturnToOldSelections" + this.ClientID, cstext2.ToString(), false);
        }
    }

    public override void DataBind()
    {
        base.DataBind();
        BindDataSource();
    }

    protected void BindDataSource()
    {
        filterControlSelectedValuesHiddenF.Value = string.Empty;

        DataTable mSourceTable = this.DataSource;
        string mDisplayValueField = this.DisplayValueField;
        string mDataValueFiled = this.DataValueFiled;

        filterGridView.DataSource = mSourceTable;
        ((BoundField)filterGridView.Columns[1]).DataField = mDisplayValueField;
        ((BoundField)filterGridView.Columns[2]).DataField = mDataValueFiled;
        filterGridView.DataBind();
    }        

    protected void okButton_Click(object sender, EventArgs e)
    {
        List<string> items = new List<string>();

        filterControlSelectedValuesHiddenF.Value = string.Empty;
        filterControlSelectedNamesValuesHiddenF.Value = string.Empty;

        foreach (GridViewRow item in filterGridView.Rows)
        {
            CheckBox CheckBox2 = (CheckBox)item.FindControl("checkBoxID");
            if (CheckBox2.Checked)
            {
                string displayField = item.Cells[1].Text;
                string codeField = item.Cells[2].Text;
                items.Add(codeField);

                if (filterControlSelectedValuesHiddenF.Value.Equals(string.Empty))
                {
                    filterControlSelectedValuesHiddenF.Value += codeField;
                    filterControlSelectedNamesValuesHiddenF.Value += displayField;
                }
                else
                {
                    filterControlSelectedValuesHiddenF.Value += ";" + codeField;
                    filterControlSelectedNamesValuesHiddenF.Value += ";" + displayField;
                }
            }
        }

        if (EntrySelected != null)
        {         
            FilterWindowEventsArg args = new FilterWindowEventsArg(items);
            EntrySelected(this, args);  
        }        
    }  
    
    public class FilterWindowEventsArg : EventArgs
    {
        private List<string> selectedItems;
        public List<string> SelectedItems
        {
            get { return selectedItems; }
        }
       
        public FilterWindowEventsArg(List<string> items)
        {
            selectedItems = items;
        }
    }

    public event CustomItemEventHandler EntrySelected;

    public delegate void CustomItemEventHandler(object sender, FilterWindow.FilterWindowEventsArg e);
}



