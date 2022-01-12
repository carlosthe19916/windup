import { Route, Routes, RouteProps } from "react-router-dom";
import Namespaces from "./pages/ApplicationList";

export const AppRoutes = () => {
  const routes: RouteProps[] = [
    {
      path: "/",
      element: <Namespaces />,
    },
  ];

  return (
    <Routes>
      {routes.map(({ path, element, ...rest }, index) => (
        <Route key={index} path={path} element={element} {...rest} />
      ))}
    </Routes>
  );
};
