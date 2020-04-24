<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="borrower.aspx.cs" Inherits="DiscInventory.borrower"  
    MasterPageFile="~/Site1.Master" ClientIDMode="Static"%>

<%-- 

Original Author: Jeffrey Kuhn
Date Created: 4/23/20
Version: 1
Date Last Modified: 4/23/20
Modified by: Jeffrey Kuhn
Modification log: Page created
 
--%>
            <%-- Content tag to replace info on the Site1.Master file --%>
            <asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
                 <h1>Welcome!</h1>
                <p>Want to sign up for borrowing a CD? Sign up here!</p>
                <div>
                    <!-- Area to enter first name -->
                    <asp:Label ID="lblFName" runat="server" Text="First Name:"></asp:Label>
                    <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
                        <!-- Validator to check if info was put in text box -->
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="" 
                        ControlToValidate="txtFName" CssClass="msgLabel">First Name is required</asp:RequiredFieldValidator>
                </div>
                <div>
                    <!-- Area to enter last name -->
                    <asp:Label ID="lblLName" runat="server" Text="Last Name:"></asp:Label>
                    <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>
                        <!-- Validator to check if info was put in text box -->
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="" 
                        ControlToValidate="txtLName" CssClass="msgLabel">Last Name is required</asp:RequiredFieldValidator>
                </div>
                <div>
                    <!-- Area to enter phone number -->
                    <asp:Label ID="lblPhone" runat="server" Text="Phone Number:"></asp:Label>
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                        <!-- Validator to check if info was put in text box -->
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="" 
                        ControlToValidate="txtPhone" TextMode="Phone" Display="Dynamic" CssClass="msgLabel">Phone number is required</asp:RequiredFieldValidator>
                        <!-- Validator to check if info put in text box is in the format of a phone number -->
                    <asp:RegularExpressionValidator ID="regexPhone" runat="server" 
                        ControlToValidate="txtPhone" Text="Use this format: 999-999-9999"
                        Display="Dynamic" CssClass="msgLabel" 
                        ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}">
                    </asp:RegularExpressionValidator>
                </div>
                <div>
                    <!-- Submit button to trigger btnSubmit_Click upon clicking it-->
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"  />
                    <!-- Clear button to clear form after clicking-->
                <asp:Button ID="btnClear" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear_Click"  />
                </div>
                <div>
                    <!-- Label to be updated upon form being correctly validated -->
                <asp:label id="lblMessage" runat="server" CssClass="msgLabel"></asp:label>
                </div>
            </asp:Content>

