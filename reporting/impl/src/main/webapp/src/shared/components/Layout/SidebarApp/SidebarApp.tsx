import React from "react";
import { Nav, NavItem, NavList } from "@patternfly/react-core";
import { HomeIcon } from "@patternfly/react-icons";

interface INavItemData {
  label: string;
  href: string;
  icon?: string;
}

const NAV_ITEMS: INavItemData[] = (window as any)["navItems"] || [];

export const SidebarApp: React.FC = () => {
  return (
    <Nav id="nav-sidebar" variant="horizontal">
      <NavList>
        <NavItem>
          <a href="/" className="pf-m-current">
            <HomeIcon />
            &nbsp;All applications
          </a>
        </NavItem>
        {NAV_ITEMS.map((item, index) => (
          <NavItem key={index}>
            <a href={item.href} className="pf-m-current">
              {item.icon && <i className={item.icon}></i>} {item.label}
            </a>
          </NavItem>
        ))}
      </NavList>
    </Nav>
  );
};
