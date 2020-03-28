<% If gsExport = "" Then %>
<% If Not gbSkipHeaderFooter Then %>
			<% If EW_DEBUG_ENABLED Then Response.Write ew_CalcElapsedTime(StartTimer) ' Display elapsed time %>
			<!-- right column (end) -->
			</div>
		</div>
	</div>
	<!-- content (end) -->
	<!-- footer (begin) --><!-- *** Note: Only licensed users are allowed to remove or change the following copyright statement. *** -->
	<div id="ewFooterRow" class="ewFooterRow">
		<div class="ewFooterText"><%= Language.ProjectPhrase("FooterText") %></div>
		<!-- Place other links, for example, disclaimer, here -->		
	</div>
	<!-- footer (end) -->	
</div>
<% End If %>
<!-- search dialog -->
<div id="ewSearchDialog" class="modal"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><h4 class="modal-title"></h4></div><div class="modal-body"></div><div class="modal-footer"><button type="button" class="btn btn-primary ewButton"><%= Language.Phrase("Search") %></button><button type="button" class="btn btn-default ewButton" data-dismiss="modal" aria-hidden="true"><%= Language.Phrase("CancelBtn") %></button></div></div></div></div>
<!-- message box -->
<div id="ewMsgBox" class="modal"><div class="modal-dialog"><div class="modal-content"><div class="modal-body"></div><div class="modal-footer"><button type="button" class="btn btn-primary ewButton" data-dismiss="modal" aria-hidden="true"><%= Language.Phrase("MessageOK") %></button></div></div></div></div>
<!-- tooltip -->
<div id="ewTooltip"></div>
<% End If %>
<% If gsExport = "" Then %>
<script type="text/javascript">
// Write your global startup script here
// document.write("page loaded");
</script>
<% End If %>
</body>
</html>
