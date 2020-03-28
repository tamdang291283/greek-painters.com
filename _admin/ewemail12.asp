<form id="ewEmailForm" class="form-horizontal ewForm ewEmailForm" action="<%= ew_CurrentPage %>">
<% If Page.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Page.Token %>">
<% End If %>
<input type="hidden" name="export" id="export" value="email">
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="sender"><%= Language.Phrase("EmailFormSender") %></label>
		<div class="col-sm-10"><input type="text" class="form-control ewControl" name="sender" id="sender"></div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="recipient"><%= Language.Phrase("EmailFormRecipient") %></label>
		<div class="col-sm-10"><input type="text" class="form-control ewControl" name="recipient" id="recipient"></div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="cc"><%= Language.Phrase("EmailFormCc") %></label>
		<div class="col-sm-10"><input type="text" class="form-control ewControl" name="cc" id="cc"></div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="bcc"><%= Language.Phrase("EmailFormBcc") %></label>
		<div class="col-sm-10"><input type="text" class="form-control ewControl" name="bcc" id="bcc"></div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="subject"><%= Language.Phrase("EmailFormSubject") %></label>
		<div class="col-sm-10"><input type="text" class="form-control ewControl" name="subject" id="subject"></div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel" for="message"><%= Language.Phrase("EmailFormMessage") %></label>
		<div class="col-sm-10"><textarea class="form-control ewControl" rows="6" name="message" id="message"></textarea></div>
	</div>
<!--
	<div class="form-group">
		<label class="col-sm-2 control-label ewLabel"><%= Language.Phrase("EmailFormContentType") %></label>
		<div class="col-sm-10">
		<label class="radio-inline ewRadio" style="white-space: nowrap;"><input type="radio" name="contenttype" value="html" checked="checked"><%= Language.Phrase("EmailFormContentTypeHtml") %></label>
		<label class="radio-inline ewRadio" style="white-space: nowrap;"><input type="radio" name="contenttype" value="url"><%= Language.Phrase("EmailFormContentTypeUrl") %></label>
		</div>
	</div>
-->
	<input type="hidden" name="contenttype" value="html">
</form>
