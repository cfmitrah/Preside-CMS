/**
 * @expressionContexts  webrequest
 * @expressionCategory  formbuilder
 * @expressionTags      formbuilderV2Form
 */
component {

	property name="rulesEngineOperatorService" inject="rulesEngineOperatorService";
	property name="formBuilderService"         inject="formBuilderService";
	property name="formBuilderFilterService"   inject="formBuilderFilterService";

	/**
	 * @question.fieldtype  formbuilderQuestion
	 * @question.item_type  number
	 *
	 */
	private boolean function evaluateExpression(
		  required string  question
		, required numeric value
		,          string  _numericOperator = "eq"
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
		  required string question
		, required string value
		,          string _numericOperator = "eq"
		,          string parentPropertyName = ""
		,          string filterPrefix       = ""
	) {
		return formBuilderFilterService.prepareFilterForSubmissionQuestionResponseMatchesNumber( argumentCollection=arguments );
	}

}