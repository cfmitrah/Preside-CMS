/**
 * The rules engine condition object represents a globally saved condition
 * that can be used to build dynamic rules throughout the system. See
 * [[rules-engine]] for a detailed guide
 *
 * @labelfield condition_name
 * @dataManagerGridFields condition_name,context,filter_object,owner,filter_sharing_scope,datemodified
 */
component extends="preside.system.base.SystemPresideObject" displayName="Rules engine: condition" {
	property name="condition_name"   type="string"  dbtype="varchar"  required=true  maxlength=200  uniqueindexes="contextname|2,filterobjectname|2";
	property name="context"          type="string"  dbtype="varchar"  required=false maxlength=100  uniqueindexes="contextname|1"      renderer="rulesEngineContextName" indexes="context";
	property name="filter_object"    type="string"  dbtype="varchar"  required=false maxlength=100  uniqueindexes="filterobjectname|1" renderer="objectName";
	property name="expressions"      type="string"  dbtype="longtext" required=true;

	property name="filter_sharing_scope" type="string"  dbtype="varchar"  required=false enum="rulesfilterScopeAll" indexes="sharingscope";
	property name="is_favourite"         type="boolean" dbtype="boolean"  required=false default=false;
	property name="allow_group_edit"     type="boolean" dbtype="boolean"  required=false default=false generator="rulesfilter.allowGroupEdit" generate="always";

	property name="owner"         relatedTo="security_user"              relationship="many-to-one" generator="rulesfilter.owner" generate="always";
	property name="user_groups"   relatedTo="security_group"             relationship="many-to-many" relatedVia="rules_filter_user_group";
	property name="filter_folder" relatedTo="rules_engine_filter_folder" relationship="many-to-one";
}