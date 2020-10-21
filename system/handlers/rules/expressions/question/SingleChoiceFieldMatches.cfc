/**
 * @expressionContexts webrequest
 * @expressionCategory formbuilder
 */
component {

	property name="rulesEngineOperatorService" inject="rulesEngineOperatorService";
	property name="formBuilderService"         inject="formBuilderService";
	property name="formBuilderFilterService"   inject="formBuilderFilterService";

	 /**
	 * @question.fieldtype      formbuilderQuestionSingle
	 * @question.object         formbuilder_question
	 * @question.item_type      radio
	 * @question.questionType   checkbox
	 * @question.multiSelect    true
	 * @value.fieldtype         formbuilderQuestionChoiceValue
	 *
	 */
	private boolean function evaluateExpression(
		  required string question
		, required string value
	) {
		var filter = prepareFilters( argumentCollection = arguments	);

		return formBuilderFilterService.evaluateQuestionSubmissionResponseMatch(
			  argumentCollection = arguments
			, userId             = payload.user.id
			, formId             = payload.formId ?: ""
			, submissionId       = payload.submissionId ?: ""
			, extraFilters       = filter
		);
	}

	/**
	 * @objects formbuilder_formsubmission
	 */
	private array function prepareFilters(
		  required string  question
		, required string  value
		,          string  parentPropertyName = ""
		,          string  filterPrefix       = ""
	) {
		return formBuilderFilterService.prepareFilterForSubmissionQuestionResponseMatchesChoiceOptions( argumentCollection=arguments, _all=false );
	}

}