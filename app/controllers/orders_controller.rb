class OrdersController < ApplicationController
  def create
    deck = Deck.find(params[:deck_id])
    order  = Order.create!(deck: deck, deck_sku: deck.sku, amount: deck.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: deck.sku,
        amount: deck.price_cents,
        currency: 'usd',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    @deck = order.deck
    @deck_community = DeckCommunity.new(deck_id: @deck.id, user_id: current_user.id)
    @deck_community.save

    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
