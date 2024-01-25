defmodule NomeDoProjetoWeb.CalculatorController do
  use NomeDoProjetoWeb, :controller

  def add(conn, %{"a" => a, "b" => b}) do
    result = String.to_integer(a) + String.to_integer(b)
    render(conn, :total, total: result)
  end

  def subtract(conn, %{"a" => a, "b" => b}) do
    result = String.to_integer(a) - String.to_integer(b)
    render(conn, :total, total: result)
  end

  def multiply(conn, %{"a" => a, "b" => b}) do
    result = String.to_integer(a) * String.to_integer(b)
    render(conn, :total, total: result)
  end

  def divide(conn, %{"a" => a, "b" => b}) do
    result = String.to_integer(a) / String.to_integer(b)
    render(conn, :total, total: result)
  end
end
