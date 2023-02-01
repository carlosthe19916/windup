package org.jboss.windup.reporting.data.rules;

import org.apache.commons.io.FileUtils;
import org.jboss.forge.furnace.Furnace;
import org.jboss.forge.furnace.addons.Addon;
import org.jboss.forge.furnace.util.AddonFilters;
import org.jboss.windup.config.AbstractRuleProvider;
import org.jboss.windup.config.GraphRewrite;
import org.jboss.windup.config.loader.RuleLoaderContext;
import org.jboss.windup.config.metadata.RuleMetadata;
import org.jboss.windup.config.operation.GraphOperation;
import org.jboss.windup.config.phase.PostReportPf4RenderingPhase;
import org.jboss.windup.graph.GraphContext;
import org.jboss.windup.reporting.service.ReportService;
import org.jboss.windup.util.ZipUtil;
import org.ocpsoft.logging.Logger;
import org.ocpsoft.rewrite.config.Configuration;
import org.ocpsoft.rewrite.config.ConfigurationBuilder;
import org.ocpsoft.rewrite.context.EvaluationContext;

import javax.inject.Inject;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

@RuleMetadata(
        phase = PostReportPf4RenderingPhase.class,
        haltOnException = true
)
public class UIRuleProvider extends AbstractRuleProvider {

    private static final Logger LOG = Logger.getLogger(UIRuleProvider.class);

    private final static String UI_ZIP_FILENAME = "pf4-windup-ui.zip";

    @Inject
    private Furnace furnace;

    // @formatter:off
    @Override
    public Configuration getConfiguration(RuleLoaderContext ruleLoaderContext) {
        return ConfigurationBuilder.begin()
                .addRule()
                .perform(new GraphOperation() {
                    @Override
                    public void perform(GraphRewrite event, EvaluationContext context) {
                        performProcess(event);
                    }
                });
    }
    // @formatter:on

    private void performProcess(GraphRewrite event) {
        GraphContext context = event.getGraphContext();
        ReportService reportService = new ReportService(context);

        Path apiDataDirectory = reportService.getApiDataDirectory();
        Path uiDirectory = reportService.getWindupUIDirectory();
        File uiDirectoryFile = uiDirectory.toFile();

        try {
            FileUtils.forceMkdir(uiDirectoryFile);

            // Copy UI ZIP
            InputStream uiZipInputStream = null;
            for (Addon addon : furnace.getAddonRegistry().getAddons(AddonFilters.allLoaded())) {
                uiZipInputStream = addon.getClassLoader().getResourceAsStream(UI_ZIP_FILENAME);
                if (uiZipInputStream != null) {
                    break;
                }
            }
            if (uiZipInputStream == null) {
                throw new IllegalStateException("Could not find UI");
            }

            Files.copy(uiZipInputStream, uiDirectory.resolve(UI_ZIP_FILENAME));

            // Unzip UI
            File uiZipFile = uiDirectory.resolve(UI_ZIP_FILENAME).toFile();
            ZipUtil.unzipToFolder(uiZipFile, uiDirectoryFile);

            // Set data
            Path sourceWindupJS = apiDataDirectory.resolve(AbstractApiRuleProvider.JAVASCRIPT_OUTPUT);

            Path targetWindupJS = uiDirectory.resolve("api").resolve(AbstractApiRuleProvider.JAVASCRIPT_OUTPUT); // "The 'api' folder represents 'pf4-ui/src/main/webapp/public/api'"
            Files.delete(targetWindupJS);

            Files.copy(sourceWindupJS, targetWindupJS);

            // Clean
            Files.delete(sourceWindupJS);
            Files.delete(uiDirectory.resolve(UI_ZIP_FILENAME));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}