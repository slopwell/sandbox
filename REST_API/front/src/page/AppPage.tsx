import { BrowserRouter, Navigate, Routes, Route } from "react-router-dom";
import { NamePage } from "@/page/name/NamePage";


export const AppPage = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Navigate to="/name" />} />
        <Route path="/name" element={<NamePage />} />
      </Routes>
    </BrowserRouter>
  );
};

