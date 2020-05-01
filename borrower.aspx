<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="borrower.aspx.cs" Inherits="DiscInventory.borrower"  
    MasterPageFile="~/Site1.Master" ClientIDMode="Static"%>

<%-- 

Original Author: Jeffrey Kuhn
Date Created: 4/23/20
Version: 1
Date Last Modified: 5/1/20
Modified by: Jeffrey Kuhn
Modification log: Page created

    5/1/2020: Added Grid View, Details View and the ability to update, delete and insert data in the database
 
--%>
            <%-- Content tag to replace info on the Site1.Master file --%>
            <asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
                <div class="tables">
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="edit"/>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Borrower_ID">
                    <Columns>
                        <asp:TemplateField HeaderText="Borrower_FName" SortExpression="Borrower_FName">
                            <EditItemTemplate>
                                <%--enter first name and validates--%>
                                <asp:TextBox ID="txtFNameE" runat="server" Text='<%# Bind("Borrower_FName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFName" runat="server" 
                                ControlToValidate="txtFNameE" Display="Dynamic" 
                                ErrorMessage="First Name is a required field" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Borrower_FName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Borrower_LName" SortExpression="Borrower_LName">
                            <EditItemTemplate>
                                <%--enter last name and validates--%>
                                <asp:TextBox ID="txtLNameE" runat="server" Text='<%# Bind("Borrower_LName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLName" runat="server" 
                                ControlToValidate="txtLNameE" Display="Dynamic" 
                                ErrorMessage="Last Name is a required field" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Borrower_LName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Borrower_Phone" SortExpression="Borrower_Phone">
                            <EditItemTemplate>
                                <%--enter phone number and validates--%>
                                <asp:TextBox ID="txtPhoneE" runat="server" Text='<%# Bind("Borrower_Phone") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                                ControlToValidate="txtPhoneE" Display="Dynamic" 
                                ErrorMessage="Phone number is a required field" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexPhone" runat="server" 
                                ControlToValidate="txtPhoneE" Text="Use this format: 999-999-9999"
                                Display="Dynamic" CssClass="msgLabel" 
                                ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                    ErrorMessage="Phone number requires correct format." ValidationGroup="edit"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Borrower_Phone") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Borrower_ID" HeaderText="Borrower_ID" SortExpression="Borrower_ID" InsertVisible="False" ReadOnly="True" />
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView> 
                </div>

                <%--data source for delete, update and insert stored procedures--%>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnection %>" 
                     SelectCommand="SELECT [Borrower_ID], [Borrower_FName], [Borrower_LName], [Borrower_Phone] FROM [Borrowed] ORDER BY [Borrower_LName], [Borrower_FName]" 
                     UpdateCommand="sp_update_borrower" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" DeleteCommand="sp_delete_borrower" 
                     InsertCommandType="StoredProcedure" InsertCommand="sp_insert_borrower">
                     <DeleteParameters>
                         <asp:Parameter Name="Borrower_ID" Type="Int32" />
                     </DeleteParameters>
                     <InsertParameters>
                         <asp:Parameter Name="Borrower_FName" Type="String" />
                         <asp:Parameter Name="Borrower_LName" Type="String" />
                         <asp:Parameter Name="Borrower_Phone" Type="String" />
                     </InsertParameters>
                     <UpdateParameters>
                         <asp:Parameter Name="Borrower_ID" Type="Int32" />
                         <asp:Parameter Name="Borrower_FName" Type="String" />
                         <asp:Parameter Name="Borrower_LName" Type="String" />
                         <asp:Parameter Name="Borrower_Phone" Type="String" />                      
                     </UpdateParameters>
                </asp:SqlDataSource>


                 <h1>Add more users?</h1>
                <p>Want to add more users for borrowing disks? Add them here!</p>
                <div class="tables2">
                    <%--Form to insert data into borrower table--%>
                    <asp:DetailsView ID="dvBorrower" runat="server"
                    AutoGenerateRows="False" DataKeyNames="Borrower_ID" DataSourceID="SqlDataSource1" OnItemInserted="dvBorrower_ItemInserted" DefaultMode="Insert">
                    <Fields>
                        <asp:TemplateField HeaderText="First Name" SortExpression="First Name">
                            <InsertItemTemplate>
                                <%--enter first name and validates--%>
                                <asp:TextBox ID="txtFName" runat="server" Text='<%# Bind("Borrower_FName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFName" runat="server" 
                                ControlToValidate="txtFName" Display="Dynamic" 
                                ErrorMessage="First Name is a required field" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name" SortExpression="Last Name">
                            <InsertItemTemplate>
                                <%--enter last name and validates--%>
                                <asp:TextBox ID="txtLName" runat="server" Text='<%# Bind("Borrower_LName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLName" runat="server" 
                                ControlToValidate="txtLName" Display="Dynamic" 
                                ErrorMessage="Last Name is a required field" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone Number" SortExpression="Phone Number">
                            <InsertItemTemplate>
                                <%--enter phone number and validates--%>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Text='<%# Bind("Borrower_Phone") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                                ControlToValidate="txtPhone" Display="Dynamic" 
                                ErrorMessage="Phone number is a required field" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexPhone" runat="server" 
                                ControlToValidate="txtPhone" Text="Use this format: 999-999-9999"
                                Display="Dynamic" CssClass="msgLabel" 
                                ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                                    ErrorMessage="Phone number requires correct format." ValidationGroup="Insert">
                            </asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowInsertButton="True" ValidationGroup="Insert"/>
                    </Fields>
                </asp:DetailsView>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    HeaderText="Please correct the following errors:" 
                    ValidationGroup="Insert" />

                    <!-- Label to be updated upon form being correctly validated -->
                <asp:label id="lblMessage" runat="server"></asp:label>
                </div>
                    <%--<!-- Area to enter first name -->
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
                <asp:label id="lblMessage" runat="server" CssClass="msgLabel"></asp:label>--%>
                
            </asp:Content>

