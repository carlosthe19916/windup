import React from "react";
import {
  EmptyState,
  Title,
  EmptyStateBody,
  Button,
  EmptyStateVariant,
  EmptyStateSecondaryActions,
  EmptyStateIcon,
} from "@patternfly/react-core";
import { RocketIcon } from "@patternfly/react-icons";
import { NavLink } from "react-router-dom";

export const ApplicationList: React.FC = () => {
  return (
    <EmptyState variant={EmptyStateVariant.small}>
      <NavLink
        to="/"
        className={({ isActive }) => {
          console.log("carlos");
          return "pf-m-current";
        }}
      >
        &nbsp;All applications
      </NavLink>

      <EmptyStateIcon icon={RocketIcon} />
      <Title headingLevel="h4" size="lg">
        Bienvenido a Searchpe
      </Title>
      <EmptyStateBody>
        Searchpe te ayuda a consumir los datos proveidos por la SUNAT a travéz
        del 'padrón reducido'. Antes de empezar a consultar datos, necesitas
        crear una <strong>Versión</strong>.
      </EmptyStateBody>
      <Button variant="primary">Ir a Versiones</Button>
      <EmptyStateSecondaryActions>
        Para aprender más visita la
        <a
          target="_blank"
          href="https://project-openubl.github.io"
          rel="noopener noreferrer"
        >
          documentación.
        </a>
      </EmptyStateSecondaryActions>
    </EmptyState>
  );
};
