import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="https://github.com/ABossOfMyself/Dice-Game.git" target="_blank" rel="noopener noreferrer">
      <PageHeader
        title="🎲 Dice Game"
        style={{ cursor: "pointer" }}
      />
    </a>
  );
}
