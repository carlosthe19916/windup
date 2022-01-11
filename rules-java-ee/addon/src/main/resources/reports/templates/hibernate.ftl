<!DOCTYPE html>

<#assign applicationReportIndexModel = reportModel.applicationReportIndexModel>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${reportModel.projectModel.name} - Hibernate Report</title>
    <link href="resources/css/patternfly/patternfly.min.css" rel="stylesheet"/>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="resources/css/font-awesome.min.css" rel="stylesheet" />
    <link href="resources/css/windup.css" rel="stylesheet" media="screen">
    <link href="resources/img/mta-icon.png" rel="shortcut icon" type="image/x-icon"/>

    <script src="resources/js/jquery-3.3.1.min.js"></script>
</head>
<body role="document">

<#include "include/page-init.ftl">

<section class="pf-c-page__main-section pf-m-light">
    <div class="pf-c-content">
        <h1>
            Hibernate Report
            <#if reportModel.projectModel??>
                :&nbsp;${reportModel.projectModel.rootFileModel.applicationName}
            </#if>
        </h1>
        <p>The Hibernate report lists the Hibernate entities and the Hibernate configuration found in the application.</p>
    </div>
</section>

<section class="pf-c-page__main-section">
    <div class="container-fluid" role="main">
        <div class="row">
            <div class="container-fluid theme-showcase" role="main">

            <#list reportModel.relatedResources.hibernateConfiguration as hibernateConfiguration>
                <#list hibernateConfiguration.hibernateSessionFactories as sessionFactory>
                    <#if iterableHasContent(sessionFactory.sessionFactoryProperties?keys)>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Session Factory: ${hibernateConfiguration.prettyPath}</h3>
                            </div>
                            <table class="table table-striped table-bordered" id="sessionFactoryPropertiesTable">
                                <tr>
                                    <th>Session Property</th><th>Value</th>
                                </tr>
                                <#list sessionFactory.sessionFactoryProperties?keys as sessionPropKey>
                                    <tr>
                                        <td>${sessionPropKey}</td>
                                        <td>${sessionFactory.sessionFactoryProperties[sessionPropKey]}</td>
                                    </tr>
                                </#list>
                            </table>
                        </div>
                    </#if>
                </#list>
            </#list>

            <#list reportModel.relatedResources.hibernateEntities>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Entities</h3>
                    </div>
                    <table class="table table-striped table-bordered" id="hibernateEntityTable">
                        <tr>
                            <th>Hibernate Entity</th><th>Table</th>
                        </tr>
                        <#items as entity>
                            <tr>
                                <td>
                                    <@render_link model=entity.javaClass project=reportModel.projectModel/>
                                </td>
                                <td>${entity.tableName!""}</td>
                            </tr>
                        </#items>
                    </table>
                </div>
            </#list>
        </div> <!-- /container -->
    </div><!--/row-->

    <#include "include/timestamp.ftl">
    </div><!-- /container main-->
</section>

<#include "include/page-end.ftl">


    <script src="resources/js/bootstrap.min.js"></script>
    <script>$(document).ready(function(){$('[data-toggle="tooltip"]').tooltip();});</script>
  </body>
</html>
