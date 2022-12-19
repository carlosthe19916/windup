package org.jboss.windup.reporting.data.dto;

import java.util.List;

public class ApplicationDependenciesDto {
    public String applicationId;
    public List<DependencyDto> dependencies;

    public static class DependencyDto {
        public String name;
        public String mavenIdentifier;
        public String sha1;
        public String version;
        public String organization;
        public List<String> foundPaths;
    }
}