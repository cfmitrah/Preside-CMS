<cfscript>
	isDraft            = IsTrue( args.isDraft   ?: "" );
	canCancel          = IsTrue( args.canCancel ?: "" );
	sendMethod         = args.sendMethod    ?: "";
	scheduleType       = args.scheduleType  ?: "";
	sendDate           = args.sendDate      ?: "";
	cancelLink         = args.cancelLink    ?: "";
	cancelPrompt       = args.cancelPrompt  ?: "";
	cancelSend         = args.cancelSend    ?: "";
	sent               = Val( args.sent               ?: "" );
	queued             = Val( args.queued             ?: "" );
	estimatedSendCount = Val( args.estimatedSendCount ?: "" );
</cfscript>
<cfoutput>
	<p class="light-grey">
		<i class="fa fa-fw fa-info-circle"></i>

		<cfif IsDraft>
			#translateResource( uri="cms:emailcenter.customTemplates.draft.notice" )#

		<cfelseif scheduleType == "repeat">
			<cfif IsDate( sendDate )>
				#translateResource( uri="cms:emailcenter.next.send.date.alert", data=[ DateTimeFormat( sendDate, "d mmm, yyyy HH:nn"), NumberFormat( estimatedSendCount ) ])#
			<cfelse>
				#translateResource( uri="cms:emailcenter.next.send.date.unknown.alert" )#
			</cfif>
		<cfelse>
			<cfif IsDate( sendDate )>
				<cfif sendDate gt now()>
					#translateResource( uri="cms:emailcenter.send.date.alert", data=[ DateTimeFormat( sendDate, "d mmm, yyyy HH:nn"), NumberFormat( estimatedSendCount ) ])#
				<cfelseif queued>
					#translateResource( uri="cms:emailcenter.sending.alert", data=[ NumberFormat( queued ), NumberFormat( sent ) ] )#
					<cfif canCancel>
						<a href="#cancelLink#" class="confirmation-prompt" title="#HtmlEditFormat( cancelPrompt )#">
							<i class="fa fa-fw fa-ban"></i>
							#cancelSend#
						</a>
					</cfif>
				<cfelseif sent>
					#translateResource( uri="cms:emailcenter.sent.alert", data=[ NumberFormat( sent ) ] )#
				<cfelse>
					#translateResource( uri="cms:emailcenter.send.date.in.past.alert", data=[ DateTimeFormat( sendDate, "d mmm, yyyy HH:nn") ] )#
				</cfif>
			<cfelse>
				#translateResource( uri="cms:emailcenter.send.date.unknown.alert" )#
			</cfif>

		</cfif>
	</p>
	<br>
</cfoutput>